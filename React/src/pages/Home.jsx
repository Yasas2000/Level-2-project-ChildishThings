import React from "react";
import "../pages/Home.css"
import Dashboard from "../components/Widgets";
import Chart from "../components/Chart"

const Home = () => {
  return (
    <div className="home">
      <div className="homeContainer">
        <div className="widgets">
          <Dashboard/>
          <Chart/>
        </div>
      </div>
    </div>
  );
};

export default Home;
  
