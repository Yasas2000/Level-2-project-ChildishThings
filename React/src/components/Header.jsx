import "./Header.css";
import NotificationsNoneOutlinedIcon from "@mui/icons-material/NotificationsNoneOutlined";
import ChatBubbleOutlineOutlinedIcon from "@mui/icons-material/ChatBubbleOutlineOutlined";
import SettingsOutlinedIcon from "@mui/icons-material/SettingsOutlined";

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
            <ChatBubbleOutlineOutlinedIcon className="icon" />
            <div className="counter">2</div>
          </div>
          <div className="item">
            <SettingsOutlinedIcon className="icon" />
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