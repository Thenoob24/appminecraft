import express, { Router } from "express";
import { getBlocks, getBlocksById, getBlocksByName } from "./Block.controller";

export const BlockController = Router();

BlockController.get("/:version/blocks", getBlocks);
BlockController.get("/:version/blocks/:id", getBlocksById);
BlockController.get("/:version/blocks/ByName/:name", getBlocksByName);