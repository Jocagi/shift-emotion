const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { getUserByEmail } = require("../lib/db");

async function signToken(user) {
  const secret = Buffer.from(process.env.JWT_SECRET, "base64");

  return jwt.sign({ email: user.email, id: user.id, role: user.role }, secret, {
    expiresIn: 86400 // expires in 24 hours
  });
}

async function getUserFromToken(token) {
  const secret = Buffer.from(process.env.JWT_SECRET, "base64");

  const decoded = jwt.verify(token.replace("Bearer ", ""), secret);

  return decoded;
}

async function login(args) {
  try {
    const user = await getUserByEmail(args.email);

    const isValidPassword = await comparePassword(
      args.password,
      user.passwordHash
    );

    if (isValidPassword) {
      const token = await signToken(user);
      return Promise.resolve({ auth: true, token: token, status: "SUCCESS", user: user.email, role: user.role });
    }
    else{
      return Promise.resolve({ auth: false, status: "ERROR" });
    }
  } catch (err) {
    console.info("Error login", err);
    return Promise.resolve({ auth: false, status: "ERROR" });
  }
}

function comparePassword(eventPassword, userPassword) {
  return bcrypt.compare(eventPassword, userPassword);
}

module.exports = {
  signToken,
  getUserFromToken,
  login
};
