import "./Header.css";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import {BiAnalyse} from "react-icons/bi";

const Header = () => {

  return (
    <div className="header">
      <div className="wrapper">
        <div className="headerLeft">
          <span className="title">Dashboard</span> 
        </div> 
        <div className="headerRight">
        <div className="items">
          <div className="item">
            <NotificationsNoneOutlinedIcon className="icon" />
            <div className="counter">1</div>
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