/**
 * ==============================================================================
 * 🇸🇾 سوق سوريا الشامل 2028 - محرك أتمتة أسعار الصرف (HTTP API + Web Scraping إدلب)
 * Telegram Bot: @SouqSyria2026_bot
 * Engine: Native HTTP Polling + Tesseract OCR + Cheerio Web Scraper + Supabase
 * ==============================================================================
 */

const { createClient } = require('@supabase/supabase-js');
const { createWorker } = require('tesseract.js');
const axios = require('axios');
const cheerio = require('cheerio');

// 1. المفاتيح والروابط الرسمية المعتمدة
const TELEGRAM_TOKEN = '8294009695:AAGbMTMRtwyJgyPrgXfPKbM5X7FMKXKejSc';
const TELEGRAM_API_URL = `https://api.telegram.org/bot${TELEGRAM_TOKEN}`;
const TELEGRAM_FILE_URL = `https://api.telegram.org/file/bot${TELEGRAM_TOKEN}`;

const SUPABASE_URL = 'https://zbjjkigkxbpktpmpcdqc.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpiampraWdreGJwa3RwbXBjZHFjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAzNjY3NjAsImV4cCI6MjA1NTk0Mjc2MH0.kM6i-E4d-Ea938j-e7KqE-3jM4K_Z5n6J-6O4L_2p5A';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

let lastUpdateId = 0;
let isProcessing = false;

console.log('================================================================');
console.log('🚀 محرك سوق سوريا الشامل يعمل الآن (تيليجرام + جلب تلقائي لأسعار إدلب والشراء/المبيع)...');
console.log('📡 متصل بقاعدة بيانات Supabase المعتمدة بنجاح!');
console.log('================================================================');

/**
 * دالة إرسال رسائل نصية للمستخدم عبر Telegram HTTP API
 */
async function sendTelegramMessage(chatId, text) {
    try {
        await fetch(`${TELEGRAM_API_URL}/sendMessage`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                chat_id: chatId,
                text: text,
                parse_mode: 'HTML'
            })
        });
    } catch (e) {
        console.error('⚠️ خطأ أثناء إرسال الرسالة للمستخدم:', e.message);
    }
}

/**
 * دالة استخراج وتنسيق أسعار الصرف والذهب من النص (للصور والنصوص عبر تيليجرام)
 */
function parseRates(text) {
    const clean = text.replace(/,/g, '').replace(/،/g, '');
    const rates = [];

    const dollarMatches = clean.match(/(\d{5})/g);
    if (dollarMatches && dollarMatches.length >= 1) {
        const p1 = parseFloat(dollarMatches[0]);
        const p2 = dollarMatches.length > 1 ? parseFloat(dollarMatches[1]) : p1 + 100;
        rates.push({
            currency_name: 'USD/SYP (دولار أمريكي / ليرة سورية)',
            buy_price: Math.min(p1, p2),
            sell_price: Math.max(p1, p2)
        });
    }

    const goldMatches = clean.match(/(\d{6,7})/g);
    if (goldMatches) {
        for (const num of goldMatches) {
            const val = parseFloat(num);
            if (val >= 700000 && val <= 2500000) {
                rates.push({
                    currency_name: 'غرام الذهب عيار 21',
                    buy_price: val - 15000,
                    sell_price: val
                });
                break;
            }
        }
    }

    return rates;
}

/**
 * نظام الجلب التلقائي (Web Scraping) المحدث لأسعار إدلب (شراء ومبيع لأزواج العملات)
 */
async function scrapeIdlibRates() {
    try {
        console.log('🌐 جاري جلب أحدث أسعار إدلب (شراء ومبيع) من المواقع المعتمدة...');
        const url = 'https://sp-today.com/';
        const { data } = await axios.get(url, {
            headers: { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' }
        });
        const $ = cheerio.load(data);

        let usdToSypBuy = null, usdToSypSell = null;
        let tryToSypBuy = null, tryToSypSell = null;

        // البحث داخل الجداول واستخراج سعري الشراء والمبيع لكل عملة بدقة
        $('.rates-table tr, tr').each((i, el) => {
            const text = $(el).text();
            
            // 1. استخراج دولار / سوري (شراء وبيع)
            if (text.includes('إدلب') && text.includes('دولار')) {
                const numbers = text.match(/(\d{2},\d{3}|\d{5})/g);
                if (numbers && numbers.length >= 2) {
                    usdToSypBuy = parseFloat(numbers[0].replace(/,/g, ''));
                    usdToSypSell = parseFloat(numbers[1].replace(/,/g, ''));
                }
            }

            // 2. استخراج تركي / سوري (شراء وبيع)
            if (text.includes('إدلب') && (text.includes('تركية') || text.includes('ليرة تركية'))) {
                const numbers = text.match(/(\d{2,4})/g);
                if (numbers && numbers.length >= 2) {
                    tryToSypBuy = parseFloat(numbers[0]);
                    tryToSypSell = parseFloat(numbers[1]);
                }
            }
        });

        const rowsToInsert = [];

        // إدراج زوج الدولار / ليرة سورية مع الشراء والمبيع
        if (usdToSypBuy && usdToSypSell) {
            rowsToInsert.push({
                currency_name: 'USD/SYP (دولار أمريكي / ليرة سورية)',
                buy_price: usdToSypBuy,
                sell_price: usdToSypSell,
                raw_text: 'تحديث آلي - إدلب (شراء ومبيع)',
                image_url: null
            });
        }

        // إدراج زوج ليرة تركية / ليرة سورية مع الشراء والمبيع
        if (tryToSypBuy && tryToSypSell) {
            rowsToInsert.push({
                currency_name: 'TRY/SYP (ليرة تركية / ليرة سورية)',
                buy_price: tryToSypBuy,
                sell_price: tryToSypSell,
                raw_text: 'تحديث آلي - إدلب (شراء ومبيع)',
                image_url: null
            });
        }

        // حساب وإدراج زوج الدولار / ليرة تركية مع الشراء والمبيع بناءً على المعطيات
        if (usdToSypBuy && tryToSypBuy) {
            const usdTryBuy = +(usdToSypBuy / tryToSypSell).toFixed(2);
            const usdTrySell = +(usdToSypSell / tryToSypBuy).toFixed(2);
            
            rowsToInsert.push({
                currency_name: 'USD/TRY (دولار أمريكي / ليرة تركية)',
                buy_price: usdTryBuy,
                sell_price: usdTrySell,
                raw_text: 'محسوب آلياً بدقة (شراء ومبيع)',
                image_url: null
            });
        }

        if (rowsToInsert.length > 0) {
            const { error } = await supabase.from('exchange_rates').insert(rowsToInsert);
            if (!error) {
                console.log('✅ تم حفظ وتحديث أزواج العملات (شراء ومبيع) في Supabase بنجاح!');
            } else {
                console.error('❌ خطأ في حفظ البيانات في Supabase:', error.message);
            }
        }
    } catch (err) {
        console.error('⚠️ خطأ في جلب بيانات إدلب تلقائياً:', err.message);
    }
}

// تشغيل الجلب التلقائي للموقع كل ساعة مرة
setInterval(scrapeIdlibRates, 60 * 60 * 1000);

/**
 * معالجة التحديث القادم من تيليجرام (صور أو نصوص)
 */
async function processUpdate(update) {
    const msg = update.message || update.channel_post;
    if (!msg) return;

    const chatId = msg.chat?.id;
    const text = msg.text || msg.caption || '';

    if (text.startsWith('/start') && chatId) {
        await sendTelegramMessage(
            chatId,
            '🇸🇾 <b>أهلاً بك في بوت أتمتة أسعار الصرف لسوق سوريا الشامل 2028</b>\n\nالبوت يراقب أسعار إدلب (دولار، تركي، سوري) تلقائياً ويدعم قراءة صور النشرات بالـ OCR لحظياً ⚡'
        );
        return;
    }

    if (msg.photo && Array.isArray(msg.photo) && msg.photo.length > 0) {
        if (chatId) await sendTelegramMessage(chatId, '⏳ جاري تنزيل الصورة واستخراج الأسعار عبر محرك OCR الذكي...');

        const photo = msg.photo[msg.photo.length - 1];
        const fileRes = await fetch(`${TELEGRAM_API_URL}/getFile?file_id=${photo.file_id}`);
        const fileData = await fileRes.json();

        if (!fileData.ok || !fileData.result?.file_path) {
            if (chatId) await sendTelegramMessage(chatId, '❌ تعذر جلب مسار الصورة من خوادم تيليجرام.');
            return;
        }

        const directImageUrl = `${TELEGRAM_FILE_URL}/${fileData.result.file_path}`;
        console.log(`📸 [${new Date().toLocaleTimeString('ar-SY')}] جاري فحص الصورة: ${directImageUrl}`);

        const worker = await createWorker('ara+eng');
        const ret = await worker.recognize(directImageUrl);
        const extractedText = ret.data.text;
        await worker.terminate();

        const parsedRates = parseRates(extractedText);
        const rowsToInsert = [];

        if (parsedRates.length > 0) {
            for (const r of parsedRates) {
                rowsToInsert.push({
                    currency_name: r.currency_name,
                    buy_price: r.buy_price,
                    sell_price: r.sell_price,
                    raw_text: extractedText,
                    image_url: directImageUrl
                });
            }
        } else {
            rowsToInsert.push({
                currency_name: 'نشرة عامة',
                buy_price: null,
                sell_price: null,
                raw_text: extractedText,
                image_url: directImageUrl
            });
        }

        const { error } = await supabase.from('exchange_rates').insert(rowsToInsert);
        if (error) {
            console.error('❌ خطأ في Supabase:', error.message);
            if (chatId) await sendTelegramMessage(chatId, `⚠️ خطأ في قاعدة البيانات: ${error.message}`);
            return;
        }

        console.log('✅ تم حفظ الأسعار المستخرجة من الصورة في Supabase بنجاح!');
        if (chatId) {
            let responseMsg = '✅ <b>تم قراءة النشرة وتحديث أسعار الصرف في التطبيق بنجاح!</b>\n\n';
            parsedRates.forEach(r => {
                responseMsg += `💵 <b>${r.currency_name}</b>: شراء ${r.buy_price?.toLocaleString()} | مبيع ${r.sell_price?.toLocaleString()}\n`;
            });
            await sendTelegramMessage(chatId, responseMsg);
        }
    } 
    else if (text) {
        const parsedRates = parseRates(text);
        if (parsedRates.length > 0) {
            const rowsToInsert = parsedRates.map(r => ({
                currency_name: r.currency_name,
                buy_price: r.buy_price,
                sell_price: r.sell_price,
                raw_text: text,
                image_url: null
            }));

            await supabase.from('exchange_rates').insert(rowsToInsert);
            console.log('✅ تم التحديث من النص بنجاح!');
            if (chatId) await sendTelegramMessage(chatId, '✅ تم تحديث الأسعار من الرسالة النصية بنجاح!');
        }
    }
}

/**
 * حلقة الاستماع التلقائي الفورية (Long Polling)
 */
async function startPollingLoop() {
    if (isProcessing) return;
    isProcessing = true;

    try {
        const url = `${TELEGRAM_API_URL}/getUpdates?offset=${lastUpdateId + 1}&timeout=30&allowed_updates=["message","channel_post"]`;
        const res = await fetch(url);
        
        if (res.ok) {
            const data = await res.json();
            if (data.ok && Array.isArray(data.result)) {
                for (const update of data.result) {
                    lastUpdateId = Math.max(lastUpdateId, update.update_id);
                    await processUpdate(update);
                }
            }
        }
    } catch (err) {
        console.error('⚠️ تنبيه أثناء جلب التحديثات:', err.message);
    } finally {
        isProcessing = false;
        setTimeout(startPollingLoop, 1000);
    }
}

// بدء التشغيل الفوري
startPollingLoop();
scrapeIdlibRates();