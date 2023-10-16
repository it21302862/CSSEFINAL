const bcrypt = require("bcrypt");
const { SiteManager } = require("../models/model_container");

const siteManagerController = {
  // Create a new site manager
  createSiteManager: async (data) => {
    try {
      const hashedPassword = await bcrypt.hash(data.password, 10);
      const newSiteManager = new SiteManager({
        name: data.name,
        email: data.email,
        password: hashedPassword,
        role: data.role || "site manager",
      });
      return await newSiteManager.save();
    } catch (error) {
      throw new Error(`Error creating site manager: ${error.message}`);
    }
  },

  // Find a site manager by email
  findSiteManagerByEmail: async (email) => {
    try {
      return await SiteManager.findOne({ email });
    } catch (error) {
      throw new Error(`Error finding site manager: ${error.message}`);
    }
  },

  // Verify site manager's password
  verifyPassword: async (password, hashedPassword) => {
    try {
      return await bcrypt.compare(password, hashedPassword);
    } catch (error) {
      throw new Error(`Error verifying password: ${error.message}`);
    }
  },

  // Update site manager details
  updateSiteManager: async (siteManagerId, newData) => {
    try {
      return await SiteManager.findByIdAndUpdate(siteManagerId, newData, {
        new: true,
      });
    } catch (error) {
      throw new Error(`Error updating site manager: ${error.message}`);
    }
  },

  // Delete site manager
  deleteSiteManager: async (siteManagerId) => {
    try {
      return await SiteManager.findByIdAndDelete(siteManagerId);
    } catch (error) {
      throw new Error(`Error deleting site manager: ${error.message}`);
    }
  },

  getSiteManagers: async () => {
    try {
      return await SiteManager.find();
    } catch (error) {
      throw new Error(`Error getting site managers: ${error.message}`);
    }
  },
  getSiteManagerById: async (id) => {
    try {
      return await SiteManager.findById(id);
    } catch (error) {
      throw new Error(`Error getting site managers: ${error.message}`);
    }
  },
};

module.exports = siteManagerController;
