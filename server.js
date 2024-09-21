const express = require('express');
const tr = require('googletrans').default;

const app = express();
const PORT = 6942;

app.get('/translate', async (req, res) => {
    const { text, a } = req.query;

    if (!text || !a) {
        return res.status(400).json({ error: 'Please provide both text and target language.' });
    }

    try {
        const result = await tr(text, { to: a });
        res.json({
            translatedText: result.text,
            sourceLanguage: result.src,
            corrections: {
                hasCorrectedText: result.hasCorrectedText,
                correctedText: result.correctedText,
                hasCorrectedLang: result.hasCorrectedLang,
            }
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Translation failed.' });
    }
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
