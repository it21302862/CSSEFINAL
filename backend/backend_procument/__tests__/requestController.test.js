const requestController = require("../controllers/requestController");
const { SupplyRequest } = require("../models/model_container");

describe("Supply Request Controller", () => {
  const mockSupplyRequestData = {
    items: [{ name: "Item1", quantity: 10 }],
    supplier: "123",
    requestedDate: new Date(),
    status: "pending",
  };

  it("should create a new supply request", async () => {
    const mockSave = jest.fn();
    SupplyRequest.prototype.save = mockSave;

    await requestController.createSupplyRequest(mockSupplyRequestData);

    expect(mockSave).toHaveBeenCalled();
    expect(mockSave.mock.calls[0][0]).toEqual(mockSupplyRequestData);
  });

  it("should find a supply request by ID", async () => {
    const mockFindById = jest.fn().mockResolvedValue(mockSupplyRequestData);
    SupplyRequest.findById = mockFindById;

    const result = await requestController.getSupplyRequestById("456");

    expect(result).toEqual(mockSupplyRequestData);
    expect(mockFindById).toHaveBeenCalledWith("456");
  });

  // Add tests for other CRUD operations as needed
});
