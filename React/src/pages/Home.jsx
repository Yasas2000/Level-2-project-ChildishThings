import React from "react";
import "../pages/Home.css"
import Dashboard from "../components/Widgets";

const Home = () => {
  return (
    <div className="home">
      <div className="homeContainer">
        <div className="widgets">
          <Dashboard/>
        </div>
      </div>
    </div>
  );
};

export default Home;
  
