import * as functions from "firebase-functions";
import * as express from "express";

const app: express.Express = express();
const cors = require("cors")({ origin: true });

const router: express.Router = express.Router();
app.use(router);

router.get("/image/:id", (req, res) => {
    cors(req, res, () => {
        const id = req.params.id;
        if (isNaN(Number(id))) {
            res.writeHead(400);
            res.end("invalid id");
        } else {
            functions.logger.info(id, { structuredData: true });
            res.set("Access-Control-Allow-Origin", "*");
            res.writeHead(200, {
                "Content-Type": "image/svg+xml",
                "Cache-Control": "public, max-age=1209600, s-maxage=5184000",
            });
            res.write("<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 100 100\"><rect x=\"0\" y=\"0\" width=\"100\" height=\"100\" fill=\"#000000\" /><text x=\"50%\" y=\"50%\" text-anchor=\"middle\" dominant-baseline=\"central\" fill=\"#ffffff\">#");
            res.write(id);
            res.write("</text></svg>");
            res.end();
        }
    });
});

export const api = functions.https.onRequest(app);
