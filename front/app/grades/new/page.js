"use client"
import { useState } from "react"
import Link from "next/link"

const Grade = async() => {
    const [qualificationId, setQualificationId] = useState("")
    const [gradeName, setGradeName] = useState("")
    const [description, setDescription] = useState("")
    const [displayOrder, setDisplayOrder] = useState("")
    const [examinerId, setExaminerId] = useState("")
    const [certificaterId, setCertificaterId] = useState("")

    const handleSubmit = async(e) => {
        e.preventDefault()
        try {
            const response = await fetch("http://localhost:3000/qualifications/10/grades", {
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
            console.log(response)
        } catch (ex) {
            alert(ex)
            console.error(ex)
        }
    }

    return(
        <div>
            <h1></h1>
            <div>
                <Link href="">資格詳細</Link>
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
                            <td><input type="text"/></td>
                        </tr>
                        <tr>
                            <td>試験実施機関</td>
                            <td><input type="text"/></td>
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
                <Link href="">資格詳細</Link>
            </div>
        </div>
    )
}
export default Grade
