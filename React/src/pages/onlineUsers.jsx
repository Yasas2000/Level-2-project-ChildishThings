import RegUserList from "../components/RegUserList";

const onlineUsers = () => {
    return (
      <div className="OnlineList">
        <div className="listContainer">
          <RegUserList/>
        </div>
      </div>
    );
  };
  
  export default onlineUsers;