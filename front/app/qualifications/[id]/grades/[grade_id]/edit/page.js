"use client"
import Link from "next/link"
import { use, useState } from "react"
import { useRouter } from "next/navigation"

const Grade = (context) => {
    const [gradeName, setGradeName] = useState("")
    const [description, setDescription] = useState("")
    const [displayOrder, setDisplayOrder] = useState("")
    const [examinerId, setExaminerId] = useState("")
    const [certificaterId, setCertificaterId] = useState("")
    const parameter = use(context.params)
    const qualificationId = parameter.id
    const gradeId = parameter.grade_id

    const router = useRouter()

    const handleSubmit = async(e) => {
        e.preventDefault()
        if (e.nativeEvent.submitter.name === 'delete') {
            const response = await fetch(`http://localhost:3000/qualifications/${qualificationId}/grades/${gradeId}`, {
                method: "DELETE",
                headers : {
                    "Accept": "application/json",
                    "Content-Type" : "application/json"
                }
            })
            router.push(`/qualifications/${qualificationId}`)
            router.refresh()
        } else if (e.nativeEvent.submitter.name === 'update') {
            alert('update')
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
                            <td><input value={certificaterId} onChange={(e) => setCertificaterId(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>試験実施機関</td>
                            <td><input value={examinerId} onChange={(e) => setExaminerId(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>説明</td>
                            <td><textarea value={description} onChange={(e) => setDescription(e.target.value)} rows="4" cols="40" name="description"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button className="submit_button" name="update">保存</button>
                    <button className="submit_button" name="delete">削除</button>
                </div>
            </form>
            <div>
                <Link href="">資格詳細</Link>
            </div>
        </div>
    )
}
export default Grade
