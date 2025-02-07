import { Request, Response } from "express";
import minecraftData from 'minecraft-data';

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