import React from "react";
import "../pages/Home.css"
import Widgets from "../components/Widgets";


const Home = () => {
  return (
    <div className="home">
      <div className="homeContainer">
        <div className="widgets">
          <Widgets/>
        </div>
      </div>
    </div>
  );
};

export default Home;
  