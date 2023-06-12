import React from 'react';
import { ApolloClient, InMemoryCache, gql, ApolloProvider, useQuery } from '@apollo/client';
import { Bar } from 'react-chartjs-2';

// Create an instance of ApolloClient
const client = new ApolloClient({
  uri: 'http://localhost:3000/analytics', // Update with your GraphQL server URL
  cache: new InMemoryCache(),
});

// Define the GraphQL query
const GET_CHART_DATA = gql`
  query {
    getChartData
  }
`;

const Chart = () => {
  const { loading, error, data } = useQuery(GET_CHART_DATA);

  if (loading) {
    return <div>Loading...</div>;
  }

  if (error) {
    return <div>Error: {error.message}</div>;
  }

  const chartData = {
    labels: data.getChartData.labels,
    datasets: [
      {
        label: 'Values',
        data: data.getChartData.data,
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1,
      },
    ],
  };

  return (
    <div>
      <h1>Chart</h1>
      <div>
        <Bar data={chartData} />
      </div>
    </div>
  );
};

const App = () => {
  return (
    <ApolloProvider client={client}>
      <Chart />
    </ApolloProvider>
  );
};

export default App;
