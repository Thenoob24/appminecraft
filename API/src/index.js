"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.server = exports.app = void 0;
exports.stopServer = stopServer;
const express_1 = __importDefault(require("express"));
const Item_route_1 = require("./Item/Item.route");
exports.app = (0, express_1.default)();
const port = process.env.PORT || 5713;
exports.app.use(express_1.default.json());
exports.app.use(Item_route_1.ItemController);
exports.app.use((req, _res, next) => {
    const timestamp = new Date().toISOString();
    console.log(`[${timestamp}] Requête reçue : ${req.method}:${req.url}`);
    next();
});
exports.server = exports.app.listen(port, () => {
    console.log(`Mon serveur démarre sur le port ${port}`);
});
function stopServer() {
    exports.server.close();
}
