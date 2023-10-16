const { SupplyRequest } = require("../models/model_container");

const requestController = {
  // Create a new supply request
  createSupplyRequest: async (data) => {
    try {
      const newSupplyRequest = new SupplyRequest(data);
      return await newSupplyRequest.save();
    } catch (error) {
      throw new Error(`Error creating supply request: ${error.message}`);
    }
  },

  // Get supply request by ID
  getSupplyRequestById: async (requestId) => {
    try {
      return await SupplyRequest.findById(requestId);
    } catch (error) {
      throw new Error(`Error finding supply request: ${error.message}`);
    }
  },

  // Update supply request details
  updateSupplyRequest: async (requestId, newData) => {
    try {
      return await SupplyRequest.findByIdAndUpdate(requestId, newData, {
        new: true,
      });
    } catch (error) {
      throw new Error(`Error updating supply request: ${error.message}`);
    }
  },

  // Delete supply request
  deleteSupplyRequest: async (requestId) => {
    try {
      return await SupplyRequest.findByIdAndDelete(requestId);
    } catch (error) {
      throw new Error(`Error deleting supply request: ${error.message}`);
    }
  },

  // Get all supply requests
  getAllSupplyRequests: async () => {
    try {
      return await SupplyRequest.find();
    } catch (error) {
      throw new Error(`Error getting supply requests: ${error.message}`);
    }
  },
};

module.exports = requestController;
