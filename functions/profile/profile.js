const { getUserByEmail } = require("db");
const { getUserFromToken } = require("utils");

module.exports.handler = async function(event) {

  console.log("Inicia Lamda profile_function");

  const userObj = await getUserFromToken(event.headers.Authorization);

  const dbUser = await getUserByEmail(userObj.email);

  return {
    statusCode: 200,
    headers: {},
    body: JSON.stringify({
      id: dbUser.id,
      email: dbUser.email,
      role: dbUser.role,
      createdAt: dbUser.createdAt
    })
  };
};