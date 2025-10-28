"use client"
import Link from "next/link"
import { use, useState, useEffect } from "react"
import { useRouter } from "next/navigation"

const New = (context) => {
    const [classificationList, setClassificationList] = useState([])
    const [categoryList, setCategoryList] = useState([])
    const [categoryId, setCategoryId] = useState("")
    const [nameJa, setNameJa] = useState("")
    const [nameEn, setNameEn] = useState("")
    const [classification, setClassification] = useState("")
    const [description, setDescription] = useState("")

    const router = useRouter()

    useEffect(() => {
        const getCategoryList = async() => {
            const response = await fetch(`${process.env.PUBLIC_API_URL}/categories`, {
                method: "GET",
                headers: { 
                    "Accept" : "application/json",
                    "Content-Type" : "application/json" 
                }
            })
            const json = await response.json()
            setCategoryList(json)
        }
        getCategoryList()
        setClassificationList([{key: '', value: ''},{key: 'national', value: '国家資格'},{ key: 'official', value: '公的資格'}, {key: 'vendor', value: '私的資格'}])
    }, [context])

    const handleSubmit = async(e) => {
        e.preventDefault()
        try {
            const response = await fetch(`${process.env.PUBLIC_API_URL}/qualifications`, {
                method: "POST",
                headers: {
                    "Accept" : "application/json",
                    "Content-Type" : "application/json"
                },
                body: JSON.stringify({
                    name_ja: nameJa,
                    name_en: nameEn,
                    category_id: categoryId,
                    classification: classification,
                    description: description
                })
            })
            const json = await response.json()
            if (response.ok) {
                router.push(`/`)
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
            <h1>資格</h1>
            <Link href={`${process.env.NEXT_PUBLIC_URL}`}>一覧</Link>
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
                            <td>資格名</td>
                            <td><input name="nameJa" value={nameJa} onChange={(e) => setNameJa(e.target.value)} type="text" /></td>
                        </tr>
                        <tr>
                            <td>資格英語名</td>
                            <td><input name="nameEn" value={nameEn} onChange={(e) => setNameEn(e.target.value)} type="text" /></td>
                        </tr>
                        <tr>
                            <td>区分</td>
                            <td>
                                <select name="classification" value={classification} onChange={(e) => setClassification(e.target.value)}>
                                    {classificationList.map(c =>
                                        <option key={c.key} value={c.key}>{c.value}</option>
                                    )}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>カテゴリー</td>
                            <td>
                                <select name="categoryId" value={categoryId} onChange={(e) => setCategoryId(e.target.value)}>
                                    {categoryList.map((q) => 
                                        <option key={q.id} value={q.id}>{q.name_ja}</option>
                                    )}
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>説明</td>
                            <td><textarea rows="4" cols="80" name="description" value={description} onChange={(e) => setDescription(e.target.value)}></textarea></td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <button className="submit_button">保存</button>
                </div>
            </form>
            <Link href={`${process.env.NEXT_PUBLIC_URL}`}>一覧</Link>
        </div>
    )
}

export default New
