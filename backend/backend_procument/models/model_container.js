// Import mongoose
const mongoose = require("mongoose");

// Define SiteManager schema
const siteManagerSchema = new mongoose.Schema({
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  role: { type: String, default: "site manager" },
});

// Define Supplier schema
const supplierSchema = new mongoose.Schema({
  name: { type: String, required: true },
  businessName: { type: String, required: true },
  address: { type: String, required: true },
});

// Define Item schema
const itemSchema = new mongoose.Schema({
  name: { type: String, required: true },
  quantity: { type: Number, required: true },
  // Add other item details as needed
});

// Define SupplyRequest schema
const supplyRequestSchema = new mongoose.Schema({
  items: [itemSchema],
  supplier: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Supplier",
    required: true,
  },
  requestedDate: { type: Date, default: Date.now },
  status: { type: String, default: "pending" },
  // Add other supply request details as needed
});

const siteSchema = new mongoose.Schema({
  name: { type: String },
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "SiteManager",
    required: true,
  },
  location: { type: String },
});

// Create models
const SiteManager = mongoose.model("SiteManager", siteManagerSchema);
const Supplier = mongoose.model("Supplier", supplierSchema);
const SupplyRequest = mongoose.model("SupplyRequest", supplyRequestSchema);
const Site = mongoose.model("Site", siteSchema);
// Export models
module.exports = {
  SiteManager,
  Supplier,
  SupplyRequest,
  Site,
};
