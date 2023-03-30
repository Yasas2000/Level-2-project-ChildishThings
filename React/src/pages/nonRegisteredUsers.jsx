import RegUserList from "../components/RegUserList";

const NonRegisteredUsers = () => {
  return( 
    <div className="NonRegisteredUserList">
    <div className="listContainer">
      <RegUserList/>
    </div>
  </div>
  );

  };
  
  export default NonRegisteredUsers;