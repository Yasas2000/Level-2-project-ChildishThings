import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend } from 'recharts';

const DonationsChart = () => {
  const data = [
    { month: 'January', amount: 1500 },
    { month: 'February', amount: 2000 },
    { month: 'March', amount: 1800 },
    { month: 'April', amount: 2200 },
    { month: 'May', amount: 2500 },
  ];

  return (
    <div>
      <h2>Donations Chart</h2>
      <BarChart width={800} height={400} data={data}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="month" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Bar dataKey="amount" fill="rgba(0, 128, 0, 0.6)" stroke="rgba(0, 128, 0, 1)" />
      </BarChart>
    </div>
  );
};

export default DonationsChart;
