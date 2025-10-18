import Link from "next/link"
import React from 'react';

const Menu = () => {
    return(
        <div className="menu_area">
            <h2 className="menu_title">メニュー</h2>
            <ul className="menu_list">
                <li className="menu_item"><Link href={`http://localhost:4000/`}>資格</Link></li>
                <li className="menu_item"><Link href={`http://localhost:4000/categories`}>カテゴリー</Link></li>
                <li className="menu_item"><Link href={`http://localhost:4000/certificaters`}>資格認定機関</Link></li>
                <li className="menu_item"><Link href={`http://localhost:4000/certificaters`}>試験実施機関</Link></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
                <li className="menu_item"><span style={{color: "yellow"}}>&#x1f6a7;（工事中）</span></li>
            </ul>
            <address>
                jiu3bao3&nbsp;(K. Y.)<br/>
            </address>
            <p className="systeminfo">
              React {React.version}
            </p>
        </div>
    )
}
export default Menu
