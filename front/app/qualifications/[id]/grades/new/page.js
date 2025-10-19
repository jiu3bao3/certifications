"use client"
import Link from "next/link"
import { use, useState, useEffect } from "react"
import { useRouter } from "next/navigation"

const Grade = (context) => {
    const [certificaterList, setCertificaterList] = useState([])
    const [examinerList, setExaminerList] = useState([])
    const [gradeName, setGradeName] = useState("")
    const [description, setDescription] = useState("")
    const [displayOrder, setDisplayOrder] = useState("")
    const [examinerId, setExaminerId] = useState("")
    const [certificaterId, setCertificaterId] = useState("")
    const parameter = use(context.params)
    const qualificationId = parameter.id

    const router = useRouter()
    useEffect(() => {
        const getExaminer = async() => {
            const response = await fetch(`http://localhost:3000/examiners`, {
                method: "GET",
                headers: { 
                    "Accept" : "application/json",
                    "Content-Type" : "application/json" 
                }
            })
            const json = await response.json()
            setExaminerList(json)
        }
        const getCertificater = async() => {
            const response = await fetch(`http://localhost:3000/certificaters`, {
                method: "GET",
                headers: { 
                    "Accept" : "application/json",
                    "Content-Type" : "application/json" 
                }
            })
            const json = await response.json()
            setCertificaterList(json)
        }
        getExaminer()
        getCertificater()
    }, [context])

    const handleSubmit = async(e) => {
        e.preventDefault()
        try {
            const response = await fetch(`http://localhost:3000/qualifications/${qualificationId}/grades`, {
                method: "POST",
                headers: {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                body: JSON.stringify({
                    grade_name : gradeName,
                    description : description,
                    display_order : displayOrder,
                    examiner_id : examinerId,
                    certificater_id : certificaterId,
                    qualification_id : qualificationId 
                })
            })
            router.push(`/qualifications/${qualificationId}`)
            router.refresh()
        } catch (ex) {
            alert(ex)
            console.error(ex)
        }
    }

    return(
        <div>
            <h1></h1>
            <div>
                <Link href={`http://localhost:4000/qualifications/${qualificationId}`}>資格詳細</Link>
            </div>
            <form onSubmit={handleSubmit}>
                <table>
                    <tbody>
                        <tr>
                            <td>グレード名</td>
                            <td><input value={gradeName} onChange={(e) => setGradeName(e.target.value)} name="gradeName" type="text"/></td>
                        </tr>
                        <tr>
                            <td>表示順</td>
                            <td><input value={displayOrder} onChange={(e) => setDisplayOrder(e.target.value)} name="displayOrder" type="number"/></td>
                        </tr>
                        <tr>
                            <td>資格認定機関</td>
                            <td>
                                <select name="certificaterId" value={certificaterId} onChange={(e) => setCertificaterId(e.target.value)}>
                                    {certificaterList.map((q) => 
                                        <option key={q.id} value={q.id}>{q.name_ja}</option>
                                    )}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>試験実施機関</td>
                            <td>
                                <select name="examinerId" value={examinerId} onChange={(e) => setExaminerId(e.target.value)}>
                                    {examinerList.map((e) =>
                                        <option key={e.id} value={e.id}>{e.name}</option>
                                    )}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>説明</td>
                            <td><textarea value={description} onChange={(e) => setDescription(e.target.value)} rows="4" cols="40" name="description"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button className="submit_button">保存</button>
                </div>
            </form>
            <div>
                <Link href={`http://localhost:4000/qualifications/${qualificationId}`}>資格詳細</Link>
            </div>
        </div>
    )
}
export default Grade
