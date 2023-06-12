import "./Header.css";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import {BiAnalyse} from "react-icons/bi";
import { Link } from 'react-router-dom';
import { useState,useEffect } from "react";
import axios from 'axios';


const Header = () => {
  const [notificationCount, setNotificationCount] = useState(0);

  useEffect(() => {
    fetchNotificationCount();
  }, []);

  const fetchNotificationCount = async () => {
    try {
      const response = await axios.get('http://localhost:3300/notification/count/admin');
      const count = response.data.count; 
      setNotificationCount(count);
    } catch (error) {
      console.error('Error fetching notification count:', error);
    }
  };

  return (
    <div className="header">
      <div className="wrapper">
        <div className="headerLeft">
          <span className="title">Dashboard</span> 
        </div> 
        <div className="headerRight">
        <div className="items">
          <div className="item">
            <Link to="/Notification">
              <NotificationsNoneOutlinedIcon className="icon" />
            </Link>
            <div className="counter">{notificationCount}</div>
          </div>
          <div className="item">
            <BiAnalyse className="icon" />
          </div>
          <div className="item">
            <img
              src="https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-default-avatar-profile-icon-vector-social-media-user-image-vector-illustration-227787227.jpg"
              alt=""
              className="avatar"
            />
          </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Header;