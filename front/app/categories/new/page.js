"use client"
import Link from "next/link"
import { use, useState, useEffect } from "react"
import { useRouter } from "next/navigation"

const NewCategory = (context) => {
    const [nameJa, setNameJa] = useState("")
    const [nameEn, setNameEn] = useState("")
    const [description, setDescription] = useState("")

    const router = useRouter()

    const handleSubmit = async(e) => {
        e.preventDefault()
        try {
            const response = await fetch(`http://localhost:3000/categories`, {
                method: "POST",
                headers: {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                body: JSON.stringify({
                    name_ja: nameJa,
                    name_en: nameEn,
                    description: description
                })
            })
            const json = await response.json()
            if (response.ok) {
                router.push(`/categories`)
                router.refresh()
            } else {
                alert(json.errors.join("\n"))
            }
        } catch (e) {
            alert(e)
        }
    }

    return(
        <div>
            <h1>カテゴリー</h1>
            <div><Link href={`http://localhost:4000/categories`}>一覧</Link></div>
            <form onSubmit={handleSubmit} >
                <table>
                    <thead>
                        <tr>
                            <th>項目</th>
                            <th>内容</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>カテゴリー名</td>
                            <td><input name="nameJa" value={nameJa} onChange={(e) => setNameJa(e.target.value)} type="text" /></td>
                        </tr>
                        <tr>
                            <td>カテゴリー名（英語）</td>
                            <td><input name="nameEn" value={nameEn} onChange={(e) => setNameEn(e.target.value)} type="text"/></td>
                        </tr>
                        <tr>
                            <td>説明</td>
                            <td><textarea name="description" value={description} onChange={(e) => setDescription(e.target.value)} rows="4" cols="80"></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button name="save" className="submit_button">保存</button>
                </div>
            </form>
            <div><Link href={`http://localhost:4000/categories`}>一覧</Link></div>
        </div>
    )
}
export default NewCategory
