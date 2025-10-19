"use client"
import Link from "next/link"
import { use, useState, useEffect } from "react"
import { useRouter } from "next/navigation"

const NewExaminer = (context) => {
    const [name, setName] = useState("")
    const [corporateNumber, setCorporateNumber] = useState("")
    const [zipcode, setZipcode] = useState("")
    const [address, setAddress] = useState("")
    const [tel, setTel] = useState("")
    const [url, setUrl] = useState("")

    const router = useRouter()

    const handleSubmit = async(e) => {
        e.preventDefault()
        try {
            const response = await fetch(`http://localhost:3000/examiners`, {
                method: "POST",
                headers: {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                body: JSON.stringify({
                    name: name,
                    corporate_number: corporateNumber,
                    zipcode: zipcode,
                    address: address,
                    url: url,
                    tel: tel
                })
            })
            const json = await response.json()
            if (!response.ok) {
                alert(json.errors.join("\n"))
            }
        } catch(ex) {
            alert(ex)
        }
        router.push(`/examiners`)
        router.refresh()
    }

    return (
        <div>
            <h1>試験実施機関</h1>
            <div>
                <Link href={`http://localhost:4000/examiners`}>一覧</Link>
            </div>
            <form onSubmit={handleSubmit}>
                <table>
                    <thead>
                        <tr>
                            <th>項目</th>
                            <th>内容</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>試験実施機関名</td>
                            <td><input name="name" value={name} onChange={(e) => setName(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>法人番号</td>
                            <td><input name="corporateNumber" value={corporateNumber} onChange={(e) => setCorporateNumber(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>所在地</td>
                            <td>
                                〒<input name="zipcode" value={zipcode} onChange={(e) => setZipcode(e.target.value)} type="text"/><br/>
                                <input name="address" value={address} onChange={(e) => setAddress(e.target.value)} type="text"/>
                            </td>
                        </tr>
                        <tr>
                            <td>電話番号</td>
                            <td><input name="tel" value={tel} onChange={(e) => setTel(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>URL</td>
                            <td><input name="url" value={url} onChange={(e) => setUrl(e.target.value)} type="text"/></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button name="create" className="submit_button">保存</button>
                </div>
            </form>
            <div>
                <Link href={`http://localhost:4000/examiners`}>一覧</Link>
            </div>
        </div>
    )
}
export default NewExaminer
