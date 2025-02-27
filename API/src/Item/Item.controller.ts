import { Request, Response } from "express";
import minecraftData, { Version } from 'minecraft-data';

export const getItems = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        const items = mineData.itemsArray;

        if (!items) res.status(204).send([]);
        else res.status(200).send(items);
    } catch (error) {
        res.status(500).send({ error: error});
    }
};

export const getItemsById = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        // récupère les données de l'item ainsi que ses crafts
        const item = mineData.items[Number(req.params.id)];

        const block = mineData.blocksByName[item.name];
        const drops = mineData.blockLoot[item.name];
        const recipes = mineData.recipes[item.id];

        const data = {... item, block : {block, drops}, recipes : recipes};

        if (!data) res.status(204).send([]);
        else res.status(200).send(data);
    } catch (error) {
        res.status(500).send({ error: error});
    }
}

export const getItemsByName = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        // récupère les données de l'item ainsi que ses crafts
        const item = mineData.itemsByName[req.params.name]; 

        const block = mineData.blocksByName[item.name];
        const drops = mineData.blockLoot[item.name];
        const recipes = mineData.recipes[item.id];


        const data = {... item, block : {block, drops}, recipes : recipes};

        if (!data) res.status(204).send([]);
        else res.status(200).send(data);
    } catch (error) {
        res.status(500).send({ error: error});
    }
}

export const getItemsForAll = async (req: Request, res: Response) => {
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

        const allData : Record<string, any> = {};

        versions.forEach((version: string) => {
            const data: Record<number, any> = {};
            const mineData = minecraftData(version);

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

                    data[item.id] = {
                        ...item,
                        block: { block, drops },
                        recipes
                    };
                });

                allData[version] = {...data};
            }
        });

        res.status(200).send(allData);

    } catch (error) {
        console.error(error);
        res.status(500).send(error);
    }
};
