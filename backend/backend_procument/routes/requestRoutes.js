const express = require("express");
const router = express.Router();
const requestController = require("../controllers/requestController");

// Create a new supply request
router.post("/supply-requests", async (req, res) => {
  try {
    const newSupplyRequest = await requestController.createSupplyRequest(
      req.body
    );
    res.status(201).json(newSupplyRequest);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get supply request by ID
router.get("/supply-requests/:id", async (req, res) => {
  try {
    const supplyRequest = await requestController.getSupplyRequestById(
      req.params.id
    );
    res.status(200).json(supplyRequest);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update supply request details
router.put("/supply-requests/:id", async (req, res) => {
  try {
    const updatedSupplyRequest = await requestController.updateSupplyRequest(
      req.params.id,
      req.body
    );
    res.status(200).json(updatedSupplyRequest);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete supply request
router.delete("/supply-requests/:id", async (req, res) => {
  try {
    const deletedSupplyRequest = await requestController.deleteSupplyRequest(
      req.params.id
    );
    res.status(200).json(deletedSupplyRequest);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all supply requests
router.get("/supply-requests", async (req, res) => {
  try {
    const allSupplyRequests = await requestController.getAllSupplyRequests();
    res.status(200).json(allSupplyRequests);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
