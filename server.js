const express = require("express");
const app = express();

app.use(express.json());

app.post("/ai", (req, res) => {
    const msg = req.body.message.toLowerCase();

    let reply = "Не понял 😈";

    if (msg.includes("заработать")) {
        reply = "Иди в шахту ⛏ или дальнобой 🚛";
    }

    if (msg.includes("куда")) {
        reply = "Начни с работы";
    }

    res.send(reply);
});

app.listen(3000, () => console.log("AI запущен"));