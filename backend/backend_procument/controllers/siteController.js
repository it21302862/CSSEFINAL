const { Site } = require("../models/model_container");

// Create a new site
exports.createSite = async (data) => {
  try {
    const newSite = new Site(data);
    return await newSite.save();
  } catch (error) {
    throw Error(error.message);
  }
};

// Get site by ID
exports.findSiteById = async (siteId) => {
  try {
    return await Site.findById(siteId).populate("createdBy");
  } catch (error) {
    throw Error(error.message);
  }
};

// Get all sites
exports.getAllSites = async (createdBy) => {
  try {
    const query = createdBy ? { createdBy } : {};
    return await Site.find(query);
  } catch (error) {
    throw Error(error.message);
  }
};

// Update site details
exports.updateSite = async (siteId, data) => {
  try {
    return await Site.findByIdAndUpdate(siteId, data, { new: true }).populate(
      "createdBy"
    );
  } catch (error) {
    throw Error(error.message);
  }
};

// Delete site
exports.deleteSite = async (siteId) => {
  try {
    return await Site.findByIdAndRemove(siteId).populate("createdBy");
  } catch (error) {
    throw Error(error.message);
  }
};
