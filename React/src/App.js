import "./App.css";
import SideBar from "./components/Sidebar";
import Header from "./components/Header";
import {BrowserRouter as Router, Routes ,Route} from "react-router-dom";
import Home from "./pages/Home";
import Users from "./pages/Users";
import Requests from "./pages/Requests";
import Analytics from "./pages/Analytics";
import Events from "./pages/Events";
import RegisteredUsers from "./pages/RegisteredUsers";
import QuotationRequests from "./pages/quotationRequests";
import Donations from "./pages/Donations";
import HelpRequests from "./pages/helpRequests";
import Notifications from "./pages/Notification";


function App() {
  return (
    <Router>
      <SideBar>  
      <Header/>
        
          <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/users" element={<Users />} />
          <Route path="/users/registeredUsers" element={<RegisteredUsers/>} />
          <Route path="/Requests" element={<Requests />} />
          <Route path="/Requests/quotationRequests" element={<QuotationRequests />} />
          <Route path="/Requests/donations" element={<Donations />} />
          <Route path="/Requests/helpRequests" element={<HelpRequests />} />
          <Route path="/analytics" element={<Analytics />} />
          <Route path="/Events" element={<Events />} />
          <Route path="/Notification" element={<Notifications/>}/>
          <Route path="*" element={<> not found</>} />
        </Routes> 
      </SideBar>
    </Router>
  );
}

export default App;