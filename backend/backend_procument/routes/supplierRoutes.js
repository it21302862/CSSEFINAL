const express = require("express");
const router = express.Router();
const supplierController = require("../controllers/supplierController");

// Create a new supplier
router.post("/suppliers", async (req, res) => {
  try {
    const newSupplier = await supplierController.createSupplier(req.body);
    res.status(201).json(newSupplier);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get supplier by ID
router.get("/suppliers/:id", async (req, res) => {
  try {
    const supplier = await supplierController.findSupplierById(req.params.id);
    res.status(200).json(supplier);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
router.get("/suppliers", async (req, res) => {
  try {
    const suppliers = await supplierController.getAllSuppliers();
    res.status(200).json(suppliers);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update supplier details
router.put("/suppliers/:id", async (req, res) => {
  try {
    const updatedSupplier = await supplierController.updateSupplier(
      req.params.id,
      req.body
    );
    res.status(200).json(updatedSupplier);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete supplier
router.delete("/suppliers/:id", async (req, res) => {
  try {
    const deletedSupplier = await supplierController.deleteSupplier(
      req.params.id
    );
    res.status(200).json(deletedSupplier);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
