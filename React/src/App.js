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
import Settings from "./pages/Settings";
import RegisteredUsers from "./pages/RegisteredUsers";
import NonRegisteredUsers from "./pages/nonRegisteredUsers";
import OnlineUsers from "./pages/onlineUsers";
import QuotationRequests from "./pages/quotationRequests";
import Donations from "./pages/Donations";
import HelpRequests from "./pages/helpRequests";


function App() {
  return (
    <Router>
      <SideBar>
      <Header/>
        
          <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/users" element={<Users />} />
          <Route path="/users/registeredUsers" element={<RegisteredUsers/>} />
          <Route path="/users/nonRegisteredUsers" element={<NonRegisteredUsers />} />
          <Route path="/users/onlineUsers" element={<OnlineUsers />} />
          <Route path="/Requests" element={<Requests />} />
          <Route path="/Requests/quotationRequests" element={<QuotationRequests />} />
          <Route path="/Requests/donations" element={<Donations />} />
          <Route path="/Requests/helpRequests" element={<HelpRequests />} />
          <Route path="/messages" element={<Messages />} />
          <Route path="/analytics" element={<Analytics />} />
          <Route path="/Events" element={<Events />} />
          <Route path="/settings" element={<Settings />} />
          <Route path="*" element={<> not found</>} />
        </Routes> 
      </SideBar>
    </Router>
  );
}

export default App;