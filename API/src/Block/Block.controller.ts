import { Request, Response } from "express";
import minecraftData from 'minecraft-data';

export const getBlocks = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        const blocks = mineData.blocksArray;

        if (!blocks) res.status(204).send([]);
        else res.status(200).send(blocks);
    } catch (error) {
        res.status(500).send({ error: error});
    }
};

export const getBlocksById = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        const block = mineData.blocks[Number(req.params.id)];

        if (!block) res.status(204).send([]);
        else res.status(200).send(block);
    } catch (error) {
        res.status(500).send({ error: error});
    }
}

export const getBlocksByName = async (req : Request, res : Response) => {
    try {
        const mineData = minecraftData(req.params.version);
        const block = mineData.blocksByName[req.params.name];

        if (!block) res.status(204).send([]);
        else res.status(200).send(block);
    } catch (error) {
        res.status(500).send({ error: error});
    }
}