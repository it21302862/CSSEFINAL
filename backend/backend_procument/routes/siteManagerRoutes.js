const express = require("express");
const router = express.Router();
const siteManagerController = require("../controllers/siteManagerController");

// Create a new site manager
router.post("/site-managers", async (req, res) => {
  try {
    const newSiteManager = await siteManagerController.createSiteManager(
      req.body
    );
    res.status(201).json(newSiteManager);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Sign in a site manager
router.post("/site-managers/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const siteManager = await siteManagerController.findSiteManagerByEmail(
      email
    );

    if (!siteManager) {
      return res.status(401).json({ error: "Invalid email or password" });
    }

    const passwordMatch = await siteManagerController.verifyPassword(
      password,
      siteManager.password
    );

    if (!passwordMatch) {
      return res.status(401).json({ error: "Invalid email or password" });
    }

    // Here you might want to generate a token for authentication

    res.status(200).json({ message: "Sign in successful" });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Update site manager details
router.put("/site-managers/:id", async (req, res) => {
  try {
    const updatedSiteManager = await siteManagerController.updateSiteManager(
      req.params.id,
      req.body
    );
    res.status(200).json(updatedSiteManager);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

// Delete site manager
router.delete("/site-managers/:id", async (req, res) => {
  try {
    const deletedSiteManager = await siteManagerController.deleteSiteManager(
      req.params.id
    );
    res.status(200).json(deletedSiteManager);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
router.get("/site-managers", async (req, res) => {
  try {
    const siteManagers = await siteManagerController.getSiteManagers();
    res.status(200).json(siteManagers);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});
router.get("/site-managers/:id", async (req, res) => {
  try {
    const siteManager = await siteManagerController.getSiteManagerById(
      req.params.id
    );
    res.status(200).json(siteManager);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;
