const express = require("express");
const tr = require("googletrans").default; 

const app = express();
const port = 6942;

app.get("/", async (req, res) => {
  const textToTranslate = req.query.text; 
  const tolanguage = req.query.lang;
  
  if (!tolanguage) {
    return res.status(400).json({ error: "変換先の言語を指定してください。ex) ?text=hello&lang=ja" });
  }
  
  if (!textToTranslate) {
    return res.status(400).json({ error: "テキストを指定してください。ex) ?text=hello&lang=ja" });
  }
  
  try {
    const result = await tr(textToTranslate, {to: tolanguage, tld: "co.jp" });
    res.json({ translatedText: result.text }); 
  } catch (error) {
    res.status(500).json({ error: "エラーが発生しました。" });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

