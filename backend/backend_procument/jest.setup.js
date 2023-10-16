const mongoose = require("mongoose");

beforeAll(async () => {
  await mongoose.connect(
    "mongodb+srv://itpprojectdb:Pass123itp@itp.jet5d6f.mongodb.net/csse"
  );
});

afterAll(async () => {
  await mongoose.connection.close();
});
