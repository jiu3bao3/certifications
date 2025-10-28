"use client"
import Link from "next/link"
import { use, useState, useEffect } from "react"
import { useRouter } from "next/navigation"

const Examiner = (context) => {
    const [name, setName] = useState("")
    const [corporateNumber, setCorporateNumber] = useState("")
    const [zipcode, setZipcode] = useState("")
    const [address, setAddress] = useState("")
    const [tel, setTel] = useState("")
    const [url, setUrl] = useState("")

    const router = useRouter()
    const parameter = use(context.params)

    useEffect(() => {
        const getExaminer = async(id) => {
            const response = await fetch(`${process.env.PUBLIC_API_URL}/examiners/${id}}`, {
                method: "GET",
                headers: { 
                    "Accept" : "application/json",
                    "Content-Type" : "application/json" 
                }
            })
            const json = await response.json()
            setName(json.name || '')
            setCorporateNumber(json.corporate_number || '')
            setZipcode(json.zipcode || '')
            setAddress(json.address || '')
            setUrl(json.url || '')
            setTel(json.tel || '')
        }
        getExaminer(parameter.examiner_id)
    }, [context])

    const handleSubmit = async(e) => {
        e.preventDefault()
        if (e.nativeEvent.submitter.name === 'delete') {
            const response = await fetch(`${process.env.PUBLIC_API_URL}/examiners/${parameter.examiner_id}`, {
                method: "DELETE",
                headers: {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                }
            })
        } else if (e.nativeEvent.submitter.name === 'update') {
            const response = await fetch(`${process.env.PUBLIC_API_URL}/examiners/${parameter.examiner_id}`, {
                method: "PATCH",
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
        }
        router.push(`/examiners`)
        router.refresh()
    }

    return (
        <div>
            <h1>試験実施機関</h1>
            <div>
                <Link href={`/examiners`}>一覧</Link>
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
                            <td><input name="name" value={name} onChange={(e) => setName(e.target.value)} type="text" className="text_field" /></td>
                        </tr>
                        <tr>
                            <td>法人番号</td>
                            <td><input name="corporateNumber" value={corporateNumber} onChange={(e) => setCorporateNumber(e.target.value)} type="text" className="text_field" /></td>
                        </tr>
                        <tr>
                            <td>所在地</td>
                            <td>
                                〒<input name="zipcode" value={zipcode} onChange={(e) => setZipcode(e.target.value)} type="text"/><br/>
                                <input name="address" value={address} onChange={(e) => setAddress(e.target.value)} type="text" className="text_field" />
                            </td>
                        </tr>
                        <tr>
                            <td>電話番号</td>
                            <td><input name="tel" value={tel} onChange={(e) => setTel(e.target.value)} type="text" className="text_field" /></td>
                        </tr>
                        <tr>
                            <td>URL</td>
                            <td><input name="url" value={url} onChange={(e) => setUrl(e.target.value)} type="text" className="text_field" /></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button name="update" className="submit_button">更新</button>
                    <button name="delete" className="submit_button">削除</button>
                </div>
            </form>
            <div>
                <Link href={`/examiners`}>一覧</Link>
            </div>
        </div>
    )
}
export default Examiner
