"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getItemsForAll = exports.getItemsByName = exports.getItemsById = exports.getItems = void 0;
const minecraft_data_1 = __importDefault(require("minecraft-data"));
const getItems = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const mineData = (0, minecraft_data_1.default)(req.params.version);
        const items = mineData.itemsArray;
        if (!items)
            res.status(204).send([]);
        else
            res.status(200).send(items);
    }
    catch (error) {
        res.status(500).send({ error: error });
    }
});
exports.getItems = getItems;
const getItemsById = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const mineData = (0, minecraft_data_1.default)(req.params.version);
        // récupère les données de l'item ainsi que ses crafts
        const item = mineData.items[Number(req.params.id)];
        const block = mineData.blocksByName[item.name];
        const drops = mineData.blockLoot[item.name];
        const recipes = mineData.recipes[item.id];
        const data = Object.assign(Object.assign({}, item), { block: { block, drops }, recipes: recipes });
        if (!data)
            res.status(204).send([]);
        else
            res.status(200).send(data);
    }
    catch (error) {
        res.status(500).send({ error: error });
    }
});
exports.getItemsById = getItemsById;
const getItemsByName = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const mineData = (0, minecraft_data_1.default)(req.params.version);
        // récupère les données de l'item ainsi que ses crafts
        const item = mineData.itemsByName[req.params.name];
        const block = mineData.blocksByName[item.name];
        const drops = mineData.blockLoot[item.name];
        const recipes = mineData.recipes[item.id];
        const data = Object.assign(Object.assign({}, item), { block: { block, drops }, recipes: recipes });
        if (!data)
            res.status(204).send([]);
        else
            res.status(200).send(data);
    }
    catch (error) {
        res.status(500).send({ error: error });
    }
});
exports.getItemsByName = getItemsByName;
const getItemsForAll = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const versions = [
            "1.7",
            "1.8",
            "1.9",
            "1.9.2",
            "1.9.4",
            "1.10",
            "1.10.1",
            "1.10.2",
            "1.11",
            "1.11.2",
            "1.12",
            "1.12.1",
            "1.12.2",
            "1.13",
            "1.13.1",
            "1.13.2",
            "1.14",
            "1.14.1",
            "1.14.3",
            "1.14.4",
            "1.15",
            "1.15.1",
            "1.15.2",
            "1.16",
            "1.16.1",
            "1.16.2",
            "1.16.3",
            "1.16.4",
            "1.17",
            "1.17.1",
            "1.18",
            "1.18.1",
            "1.18.2",
            "1.19",
            "1.19.2",
            "1.19.3",
            "1.19.4",
            "1.20",
            "1.20.1",
            "1.20.2",
            "1.20.3",
            "1.20.4",
            "1.20.5",
            "1.20.6",
            "1.21.1",
            "1.21.3",
            "1.21.4"
        ];
        const allData = {};
        versions.forEach((version) => {
            const data = [];
            const mineData = (0, minecraft_data_1.default)(version);
            if (!mineData || !mineData.itemsArray) {
                console.warn(`⚠️ Aucune donnée trouvée pour la version ${version}`);
                return; // Ignore cette version et passe à la suivante
            }
            else {
                const itemsVersion = mineData.itemsArray;
                itemsVersion.forEach((item) => {
                    const block = mineData.blocksByName && mineData.blocksByName[item.name] ? mineData.blocksByName[item.name] : null;
                    const drops = mineData.blockLoot && mineData.blockLoot[item.name] ? mineData.blockLoot[item.name] : [];
                    const recipes = mineData.recipes && mineData.recipes[item.id] ? mineData.recipes[item.id] : [];
                    data.push(Object.assign(Object.assign({}, item), { block: { block, drops }, recipes }));
                });
                allData[version] = Object.assign({}, data);
            }
        });
        res.status(200).send(allData);
    }
    catch (error) {
        console.error(error);
        res.status(500).send(error);
    }
});
exports.getItemsForAll = getItemsForAll;
