const supplierController = require("../controllers/supplierController");
const { Supplier } = require("../models/model_container");

describe("Supplier Controller", () => {
  const mockSupplierData = {
    name: "ABC Supplier",
    businessName: "ABC Ltd",
    address: "123 Main Street",
  };

  it("should create a new supplier", async () => {
    const mockSave = jest.fn();
    Supplier.prototype.save = mockSave;

    await supplierController.createSupplier(mockSupplierData);

    expect(mockSave).toHaveBeenCalled();
    expect(mockSave.mock.calls[0][0]).toEqual(mockSupplierData);
  });

  it("should find a supplier by ID", async () => {
    const mockFindById = jest.fn().mockResolvedValue(mockSupplierData);
    Supplier.findById = mockFindById;

    const result = await supplierController.findSupplierById("123");

    expect(result).toEqual(mockSupplierData);
    expect(mockFindById).toHaveBeenCalledWith("123");
  });

  // Add tests for other CRUD operations as needed
});
