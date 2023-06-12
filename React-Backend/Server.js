const { ApolloServer, gql } = require('apollo-server');
const { MongoClient } = require('mongodb');
const { ObjectId } = require('mongodb');

// MongoDB connection URL
const url = 'mongodb+srv://ekanayakaym20:2ilctvjCgYFhYP2W@cluster0.vyyy7ro.mongodb.net/Childish-Backend';
// MongoDB database name
const dbName = 'L2-Project';
// MongoDB collection name
const collectionName = 'your-collection-name';

// Define your GraphQL schema
const typeDefs = gql`
  type Query {
    getData: [Data]
  }

  type Data {
    id: ID
    name: String
    value: Int
  }
`;

async function connectToMongo() {
  const client = new MongoClient(url);

  try {
    await client.connect();
    const db = client.db(dbName);
    const collection = db.collection(collectionName);

    const data = await collection.find().toArray();

    return data;
  } finally {
    await client.close();
  }
}

// Define your resolvers
const resolvers = {
  Query: {
    getData: () => connectToMongo(),
  },
};

// Create an instance of ApolloServer
const server = new ApolloServer({ typeDefs, resolvers });

// Start the server
server.listen().then(({ url }) => {
  console.log(`Server running at ${url}`);
});
