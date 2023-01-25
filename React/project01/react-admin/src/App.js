import { ColorModeContext, useMode } from "./theme";
import { CssBaseline, ThemeProvider } from "@mui/material";
import {Routes ,Route} from "react-router-dom";
import Topbar from "./Scenes/Global/Topbar";
import Sidebar from "./Scenes/Global/Sidebar";
import Dashboard from "./Scenes/Dashoard";
// import OnlineUsers from "./Scenes/onlineUsers";
// import RegisteredUsers from "./Scenes/registeredUsers";
// import QuotationRequests from "./Scenes/quotationRequests";
// import Donations from "./Scenes/donations";
// import HelpRequests from "./Scenes/helpRequests";
// import Events from "./Scenes/events";
// import Chats from "./Scenes/chats";
// import Settings from "./Scenes/settings";

function App() {
  const [theme, colorMode] = useMode();
  return (
    <ColorModeContext.Provider value={colorMode}>
      <ThemeProvider theme={theme}>
        <CssBaseline/>
        <div className="app">
          <Sidebar/>
          <main className="content">
            <Topbar/>
            <Routes>
              <Route path="/" element= {<Dashboard/>}/>
              {/* <Route path="/onlineUsers" element= {<OnlineUsers/>}/>
              <Route path="/registeredUsers" element= {<RegisteredUsers/>}/>
              <Route path="/quotationRequests" element= {<QuotationRequests/>}/>
              <Route path="/donations" element= {<Donations/>}/>
              <Route path="/helpRequests" element= {<HelpRequests/>}/>
              <Route path="/events" element= {<Events/>}/> 
              <Route path="/chats" element= {<Chats/>}/>
              <Route path="/settings" element= {<Settings/>}/>*/}
            </Routes>
          </main>
        </div>
     </ThemeProvider>
    </ColorModeContext.Provider>
  );
}

export default App;
