"use client"
import Link from "next/link"
import { useSearchParams } from 'next/navigation';
import { use, useState, useEffect } from "react"

const Home = (context) => {
  const options = { national: '国家資格', official: '公的資格', private: '私的資格' }
  const [categories, setCategories] = useState([])
  const [qualifications, setQualifications] = useState([])
  const [qualificationName, setQualificationName] = useState("")
  const [categoryId, setCategoryId] = useState("")
  const [selected, setSelected] = useState([])

  const searchParams = useSearchParams();

  const toggleOption = (option) => {
    setSelected((prev) =>
      prev.includes(option) ? prev.filter((item) => item !== option) : [...prev, option]
    )
  };

  useEffect(() => {
    const getCategories = async() => {
      const response = await fetch(`${process.env.PUBLIC_API_URL}/categories`, {
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
      const response = await fetch(`${process.env.PUBLIC_API_URL}?${query}`, {
        method: "GET",
        headers : {
          "Accept": "application/json",
          "Content-Type" : "application/json"
        }
      })
      const json = await response.json()
      const qualification_name = searchParams.get('qualification_name') || '';
      const category_id = searchParams.get('category_id') || '';
      const selectedClassifications = []
      setQualifications(json)
      setQualificationName(qualification_name)
      setCategoryId(category_id)
      Object.entries(options).forEach(([k, _v]) => {
        const selected = searchParams.get(`classifications[${k}]`) || ''
        if(selected) {
          selectedClassifications.push(k)
        }
      })
      setSelected(selectedClassifications)
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
                      {Object.entries(options).map(([key, value]) => (
                        <label key={key} style={{ display: 'block' }}>
                          <input type="checkbox" name={`classifications[${key}]`} checked={selected.includes(key)} onChange={() => toggleOption(key)} />{value}
                        </label>
                      ))}
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

