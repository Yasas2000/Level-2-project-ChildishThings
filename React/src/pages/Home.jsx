import React from "react";
import "../pages/Home.css"
import Widgets from "../components/Widgets";
import EventList from "../components/EventList";

const Home = () => {
  return (
    <div className="home">
      <div className="homeContainer">
        <div className="widgets">
          <Widgets/>
        </div>
          <EventList/>
      </div>
    </div>
  );
};

export default Home;
  
