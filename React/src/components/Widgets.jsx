import "./Widgets.css"
import React, { useState, useEffect } from 'react';
import axios from 'axios';

function Dashboard() {
  const [userCount, setUserCount] = useState(0);
  const [nonRegisteredUserCount, setNonRegisteredUserCount] = useState(0);
  const [quotationRequestCount, setQuotationRequestCount] = useState(0);
  const [donationCount, setDonationCount] = useState(0);
  const [helpRequestCount, setHelpRequestCount] = useState(0);

  useEffect(() => {
    fetchData();
  }, []);

  const fetchData = () => {
    axios.get('http://localhost:5000/users/count')
      .then((response) => {
        console.log(response.data);
        setUserCount(response.data);
      })
      .catch((error) => {
        console.error('Error fetching user count:', error);
      });

    // Fetch other data for widgets
    axios.get('http://localhost:3300/count')
      .then((response) => {
        console.log(response.data);
        setNonRegisteredUserCount(response.data);
      })
      .catch((error) => {
        console.error('Error fetching non-registered user count:', error);
      });

    axios.get('http://localhost:3300/api/QuotationCount')
      .then((response) => {
        console.log(response.data);
        setQuotationRequestCount(response.data);
      })
      .catch((error) => {
        console.error('Error fetching quotation request count:', error);
      });

    axios.get('http://localhost:3300/donation/count')
      .then((response) => {
        console.log(response.data);
        setDonationCount(response.data);
      })
      .catch((error) => {
        console.error('Error fetching donation count:', error);
      });

    axios.get('http://localhost:3300/edurequest/RequestCount')
      .then((response) => {
        console.log(response.data);
        setHelpRequestCount(response.data);
      })
      .catch((error) => {
        console.error('Error fetching help request count:', error);
      });
  };

  return (
    <div className="dashboard">
      {/* Render widgets with their respective counts */}
      <Widgets
        userCount={userCount}
        nonRegisteredUserCount={nonRegisteredUserCount}
        quotationRequestCount={quotationRequestCount}
        donationCount={donationCount}
        helpRequestCount={helpRequestCount}
      />
    </div>
  );
}

function Widgets({
  userCount,
  nonRegisteredUserCount,
  quotationRequestCount,
  donationCount,
  helpRequestCount,
}) {
  return (
    <div className="widgets">
      <div className="eventsCorner"></div>
      <div className="heading">
        <span className="headingTitle">Users</span>
      </div>
      <div className="topWidget">
        <div className="widgetItem">
          <span className="widgetTitle">Registered Users</span>
          <div className="countContainer">
            <span className="count">{userCount}</span>
          </div>
        </div>
        <div className="widgetItem">
          <span className="widgetTitle">Non-Registered Users</span>
          <div className="countContainer">
            <span className="count">{nonRegisteredUserCount}</span>
          </div>
        </div>
      </div>
      <div className="heading">
        <span className="headingTitle">Requests</span>
      </div>
      <div className="bottomWidget">
        <div className="widgetItem">
          <span className="widgetTitle">Quotation Requests</span>
          <div className="countContainer">
            <span className="count">{quotationRequestCount}</span>
          </div>
        </div>
        <div className="widgetItem">
          <span className="widgetTitle">Donations</span>
          <div className="countContainer">
            <span className="count">{donationCount}</span>
          </div>
        </div>
        <div className="widgetItem">
          <span className="widgetTitle">Help Requests</span>
          <div className="countContainer">
            <span className="count">{helpRequestCount}</span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Dashboard;
