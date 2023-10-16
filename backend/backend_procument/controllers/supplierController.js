const { Supplier } = require("../models/model_container");

const supplierController = {
  // Create a new supplier
  createSupplier: async (data) => {
    try {
      const newSupplier = new Supplier(data);
      return await newSupplier.save();
    } catch (error) {
      throw new Error(`Error creating supplier: ${error.message}`);
    }
  },

  // Find a supplier by ID
  findSupplierById: async (supplierId) => {
    try {
      return await Supplier.findById(supplierId);
    } catch (error) {
      throw new Error(`Error finding supplier: ${error.message}`);
    }
  },

  // Update supplier details
  updateSupplier: async (supplierId, newData) => {
    try {
      return await Supplier.findByIdAndUpdate(supplierId, newData, {
        new: true,
      });
    } catch (error) {
      throw new Error(`Error updating supplier: ${error.message}`);
    }
  },

  // Delete supplier
  deleteSupplier: async (supplierId) => {
    try {
      return await Supplier.findByIdAndDelete(supplierId);
    } catch (error) {
      throw new Error(`Error deleting supplier: ${error.message}`);
    }
  },
  getAllSuppliers: async () => {
    try {
      return await Supplier.find();
    } catch (error) {
      throw new Error(`Error getting suppliers: ${error.message}`);
    }
  },
};

module.exports = supplierController;
