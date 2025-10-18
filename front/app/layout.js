import "./globals.css"
import Menu from "./components/menu"

const RootLayout = ({ children }) => {
  return (
    <html lang="en">
      <body>
        <Menu/>
        <div className="main">
          {children}
        </div>
      </body>
    </html>
  )
}
export default RootLayout
