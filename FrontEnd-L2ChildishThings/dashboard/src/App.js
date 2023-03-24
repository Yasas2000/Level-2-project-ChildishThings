import "./App.css";
import SideBar from "./components/Sidebar";
import Header from "./components/Header";
import {BrowserRouter as Router, Routes ,Route} from "react-router-dom";
import Home from "./pages/Home";
import Users from "./pages/Users";
import Requests from "./pages/Requests";
import Messages from "./pages/Messages";
import Analytics from "./pages/Analytics";
import Events from "./pages/Events";
import Setting from "./pages/Setting";

function App() {
  return (
    <Router>
      <SideBar>
      <Header/>
        
          <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/users" element={<Users />} />
          <Route path="/users/registeredUsers" element={<registeredUsers />} />
          <Route path="/users/nonRegisteredUsers" element={<nonRegisteredUsers />} />
          <Route path="/users/onlineUsers" element={<onlineUsers />} />
          <Route path="/Requests" element={<Requests />} />
          <Route path="/messages" element={<Messages />} />
          <Route path="/analytics" element={<Analytics />} />
          <Route path="/Events" element={<Events />} />
          <Route path="/settings" element={<Setting />} />

          <Route path="*" element={<> not found</>} />
        </Routes> 
      </SideBar>
    </Router>
  );
}

export default App;