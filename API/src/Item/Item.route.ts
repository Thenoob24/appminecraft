import express, { Router } from "express";
import { getItems, getItemsById, getItemsByName, getItemsForAll } from "./Item.controller";

export const ItemController = Router();

ItemController.get("/:version/items", getItems);
ItemController.get("/:version/items/:id", getItemsById);
ItemController.get("/:version/items/ByName/:name", getItemsByName);
ItemController.get("/items", getItemsForAll);