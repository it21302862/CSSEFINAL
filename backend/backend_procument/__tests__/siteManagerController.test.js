const bcrypt = require("bcrypt");
const siteManagerController = require("../controllers/siteManagerController");
const { SiteManager } = require("../models/model_container");

jest.mock("bcrypt");

describe("Site Manager Controller", () => {
  const mockSiteManagerData = {
    name: "John Doe",
    email: "john.doe@example.com",
    password: "password123",
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it("should create a new site manager", async () => {
    bcrypt.hash.mockResolvedValue("hashedPassword");

    const mockSave = jest.fn();
    SiteManager.prototype.save = mockSave;

    await siteManagerController.createSiteManager(mockSiteManagerData);

    expect(mockSave).toHaveBeenCalled();
    expect(mockSave.mock.calls[0][0].password).toEqual("hashedPassword");
  });

  it("should find a site manager by email", async () => {
    const mockFindOne = jest.fn().mockResolvedValue(mockSiteManagerData);
    SiteManager.findOne = mockFindOne;

    const result = await siteManagerController.findSiteManagerByEmail(
      "john.doe@example.com"
    );

    expect(result).toEqual(mockSiteManagerData);
    expect(mockFindOne).toHaveBeenCalledWith({ email: "john.doe@example.com" });
  });

  // Add tests for other CRUD operations as needed
});
