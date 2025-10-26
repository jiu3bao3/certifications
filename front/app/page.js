"use client"
import Link from "next/link"
import { useSearchParams } from 'next/navigation';
import { use, useState, useEffect } from "react"

const Home = (context) => {
  const classificationMap = { national: '国家資格', official: '公的資格', private: '私的資格' }
  const [categories, setCategories] = useState([])
  const [qualifications, setQualifications] = useState([])
  const [qualificationName, setQualificationName] = useState("")
  const [categoryId, setCategoryId] = useState("")

  const searchParams = useSearchParams();

  useEffect(() => {
    const getCategories = async() => {
      const response = await fetch(`http://localhost:3000/categories`, {
        method: "GET",
        headers : {
          "Accept": "application/json",
          "Content-Type" : "application/json"
        }
      })
      const json = await response.json()
      setCategories(json)
    }
    const getQualifications = async(params) => {
      const builder = []
      searchParams.forEach((value, key) => {
        if(value) {
          builder.push(`${key}=${value}`)
        }
      })
      const query = builder.join('&')
      const response = await fetch(`http://localhost:3000?${query}`, {
        method: "GET",
        headers : {
          "Accept": "application/json",
          "Content-Type" : "application/json"
        }
      })
      const json = await response.json()
      setQualifications(json)
      setQualificationName(searchParams.get('qualification_name') || '')
      setCategoryId(searchParams.get('category_id') || '')
    }
    getCategories()
    getQualifications(searchParams)
  }, [context])

  return (
    <div>
      <h1>資格</h1>
      <div>
        <form>
          <table className="borderless">
            <tbody>
                <tr>
                    <th className="borderless">資格名</th>
                    <td className="borderless"><input type="text" value={qualificationName} onChange={(e) => setQualificationName(e.target.value)} name="qualification_name" className="text_field"/></td>
                </tr>
                <tr>
                    <th className="borderless">区分</th>
                    <td className="borderless">
                      <label><input name="classifications[national]" type="checkbox" /></label>国家資格
                      <label><input name="classifications[official]" type="checkbox" /></label>公的資格
                      <label><input name="classifications[private]" type="checkbox" /></label>私的資格
                    </td>
                </tr>
                <tr>
                    <th className="borderless">カテゴリー</th>
                    <td className="borderless">
                      <select name="category_id" value={categoryId} onChange={(e) => setCategoryId(e.target.value)}>
                        <option key="" value=""></option>
                        {categories.map(c=> 
                          <option key={c.id} value={c.id}>{c.name_ja}</option>
                        )}
                      </select>
                    </td>
                </tr>
              </tbody>
            </table>
            <div style={{textAlign: "right"}}>
              <button type="submit" className="submit_button">検索</button>
            </div>
        </form>
      </div>
      <hr/>
      <div>
        <Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/new/`}>新規登録</Link>
      </div>
      <table>
        <thead>
          <tr>
            <th>カテゴリー</th>
            <th>区分</th>
            <th>資格名</th>
            <th>参照</th>
            <th>編集</th>
          </tr>
        </thead>
        <tbody>
          {qualifications.map((q, idx) =>
            <tr key={q.id} className={idx % 2 == 0 ? 'even' : 'odd'}>
              <td>{q.category}</td>
              <td>{q.classification}</td>
              <td>{q.name_ja}</td>
              <td><Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/${q.id}`}>参照</Link></td>
              <td><Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/${q.id}/edit`}>編集</Link></td>
            </tr>
          )}
        </tbody>
      </table>
      <div>
        <Link href={`${process.env.NEXT_PUBLIC_URL}/qualifications/new/`}>新規登録</Link>
      </div>
    </div>
  )
}

export default Home

