const express = require("express");
const router = express.Router();
const siteController = require("../controllers/siteController");

// Create a new site
router.post("/sites", async (req, res) => {
  try {
    const newSite = await siteController.createSite(req.body);
    res.status(201).json(newSite);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get site by ID
router.get("/sites/:id", async (req, res) => {
  try {
    const site = await siteController.findSiteById(req.params.id);
    res.status(200).json(site);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Get all sites
router.get("/site/:createdBy", async (req, res) => {
  try {
    const createdBy = req.params.createdBy;
    const sites = await siteController.getAllSites(createdBy);
    res.status(200).json(sites);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update site details
router.put("/sites/:id", async (req, res) => {
  try {
    const updatedSite = await siteController.updateSite(
      req.params.id,
      req.body
    );
    res.status(200).json(updatedSite);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete site
router.delete("/sites/:id", async (req, res) => {
  try {
    const deletedSite = await siteController.deleteSite(req.params.id);
    res.status(200).json(deletedSite);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
